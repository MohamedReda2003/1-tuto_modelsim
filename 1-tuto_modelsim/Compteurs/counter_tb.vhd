library ieee;
use ieee.std_logic_1164.all;

entity counter_tb is
end entity counter_tb;

architecture tb of counter_tb is
    constant T : time := 10 ns;
    constant N : positive := 2;
    signal tb_clk   : std_logic := '0';
    signal tb_rst_n : std_logic;
    signal tb_en    : std_logic;
    signal tb_q     : std_logic_vector(N-1 downto 0);
    signal tb_done  : boolean := false;
begin
    uut : entity work.counter
        generic map (N => N)
        port map (
            i_clk   => tb_clk,
            i_rst_n => tb_rst_n,
            i_en    => tb_en,
            o_q     => tb_q
        );

    -- Clock
    process
    begin
        while not tb_done loop
            tb_clk <= '0'; wait for T/2;
            tb_clk <= '1'; wait for T/2;
        end loop;
        wait;
    end process;

    -- Stimuli
    process
    begin
        tb_rst_n <= '0'; tb_en <= '1';
        wait for 12 ns;
        tb_rst_n <= '1';
        wait for 6*T;                   -- counting + wrap-around

        tb_en <= '0'; wait for 3*T;     -- counter frozen
        tb_en <= '1'; wait for 3*T;     -- resumes

        wait for 3 ns;
        tb_rst_n <= '0'; wait for 4 ns; -- asynchronous reset
        tb_rst_n <= '1'; wait for 3*T;

        tb_done <= true;
        wait;
    end process;
end architecture tb;
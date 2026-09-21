library ieee;
use ieee.std_logic_1164.all;

entity dff_tb is
end entity dff_tb;

architecture tb of dff_tb is
    constant T : time := 10 ns;
    signal tb_clk   : std_logic := '0';
    signal tb_rst_n : std_logic;
    signal tb_en    : std_logic;
    signal tb_d     : std_logic;
    signal tb_q     : std_logic;
    signal tb_done  : boolean := false;
begin
    uut : entity work.dff
        port map (
            i_clk   => tb_clk,
            i_rst_n => tb_rst_n,
            i_en    => tb_en,
            i_d     => tb_d,
            o_q     => tb_q
        );

    -- Horloge
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
        tb_rst_n <= '0'; tb_en <= '1'; tb_d <= '1';
        wait for 12 ns;                 -- reset actif : q = 0
        tb_rst_n <= '1';
        wait for 10 ns;                 -- q suit d = 1

        tb_d <= '0'; wait for 10 ns;    -- q = 0
        tb_d <= '1'; wait for 10 ns;    -- q = 1

        tb_en <= '0';                   -- enable coupé
        tb_d <= '0'; wait for 20 ns;    -- q reste à 1

        tb_en <= '1'; wait for 10 ns;   -- q = 0

        tb_d <= '1'; wait for 3 ns;
        tb_rst_n <= '0'; wait for 4 ns; -- reset asynchrone, en plein milieu d'une période
        tb_rst_n <= '1'; wait for 10 ns;

        tb_done <= true;
        wait;
    end process;
end architecture tb;
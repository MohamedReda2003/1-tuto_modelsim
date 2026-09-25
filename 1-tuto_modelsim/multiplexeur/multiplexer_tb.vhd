library ieee;
use ieee.std_logic_1164.all;

entity multiplexer_tb is
end entity multiplexer_tb;

architecture tb of multiplexer_tb is
    signal tb_sel : std_logic;
    signal tb_data_0 : std_logic_vector(3 downto 0);
    signal tb_data_1 : std_logic_vector(3 downto 0);
    signal tb_data_out : std_logic_vector(3 downto 0);
begin
    uut : entity work.multiplexer
        generic map (
            BUS_WIDTH => 2
        )
        port map (
            i_sel => tb_sel,
            i_data_0 => tb_data_0,
            i_data_1 => tb_data_1,
            o_data => tb_data_out
        );

    process
    begin
        tb_sel <= '0';
        tb_data_0 <= "00";
        tb_data_1 <= "11";
        wait for 10 ns;
        tb_sel <= '1';
        wait for 10 ns;
        tb_data_0 <= "11";
        wait for 10 ns;
        tb_data_0 <= "UU"; -- Undefined inputs, should lead to undefined outputs
        wait for 10 ns;
        wait;
    end process;
end architecture tb;
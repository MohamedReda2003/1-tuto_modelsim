library ieee;
use ieee.std_logic_1164.all;

entity dff is 
    port (
        i_clk: in std_logic;
        i_d : in std_logic;
        i_rst_n: in std_logic;
        i_en: in std_logic;
        o_q : out std_logic
    );
end entity dff;

architecture Behavioral of dff is
    signal r_q : std_logic := '0';
begin
    process(i_clk, i_rst_n)
    begin
        if i_rst_n = '0' then
            r_q <= '0';
        elsif (rising_edge(i_clk)) then
            if (i_en = '1') then
                r_q <= i_d;
            end if;
        end if;
    end process;
    o_q <= r_q;
end architecture Behavioral;
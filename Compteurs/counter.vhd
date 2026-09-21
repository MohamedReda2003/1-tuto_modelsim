library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    generic (
        N : positive := 2
    );
    port (
        i_clk   : in  std_logic;
        i_rst_n : in  std_logic;
        i_en    : in  std_logic;
        o_q : out std_logic_vector(N-1 downto 0)
    );
end entity counter;

architecture rtl of counter is
    signal r_count : unsigned(N-1 downto 0);
begin
    process(i_clk, i_rst_n)
    begin
        if (i_rst_n = '0') then
            r_count <= (others => '0');
        elsif rising_edge(i_clk) then
            if i_en = '1' then
                if (r_count = (2**N - 1)) then
                    r_count <= (others => '0');
                else
                    r_count <= r_count + 1;
                end if;
            end if;
        end if;
    end process;

    o_q <= std_logic_vector(r_count);
end architecture rtl;
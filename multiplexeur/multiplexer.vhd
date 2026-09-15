library ieee;
use ieee.std_logic_1164.all;

entity multiplexer is
    generic (
        BUS_WIDTH : positive := 4  -- Number of inputs
    );
    port (
        i_sel : in std_logic;  -- Selection input
        i_data_0 : in std_logic_vector(BUS_WIDTH-1 downto 0);  -- Input data 1
        i_data_1 : in std_logic_vector(BUS_WIDTH-1 downto 0);  -- Input data 2
        o_data : out std_logic_vector(BUS_WIDTH-1 downto 0) -- Output data
    );
end entity multiplexer;

architecture when_else of multiplexer is
begin
    o_data <= i_data_0 when i_sel = '0' else
              i_data_1 when i_sel = '1' else
              (others => 'U');
end architecture when_else;
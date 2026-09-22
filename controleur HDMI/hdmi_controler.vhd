library ieee;
use ieee.std_logic_1164.all;

entity hdmi_controler is
    generic (
        h_res : positive := 720;
        v_res : positive := 480;

        h_sync : positive := 61;
        h_fp : positive := 58;
        h_bp : positive := 18;

        v_sync : positive := 5;
        v_fp : positive := 30;
        v_bp : positive := 9
    );
    port (
        i_clk   : in  std_logic;
        i_rst_n : in  std_logic;

        o_hdmi_hs : out std_logic;
        o_hdmi_vs: out std_logic;
        o_hdmi_de: out std_logic;

        o_pixel_en : out std_logic;
        o_pixel_address : out natural range 0 to (h_res * v_res - 1);
        o_x_counter : out natural range 0 to (h_res - 1);
        o_y_counter : out natural range 0 to (v_res - 1)
    );
end entity hdmi_controler;

architecture rtl of hdmi_controler is
    constant h_start : positive := h_sync + h_fp;
    constant h_end: positive := h_start + h_res;
    constant h_total: positive := h_end + h_bp;

    signal r_h_counter : natural range 0 to h_total := 0;
    signal r_h_active : std_logic := '0';

begin
    process(i_clk, i_rst_n)
    begin
        if (i_rst_n = '0') then
            r_h_counter <= 0;
            r_h_active <= '0';
        elsif rising_edge(i_clk) then
            if (r_h_counter = h_total) then
                r_h_counter <= 0;
            else
                r_h_counter <= r_h_counter + 1;
            end if;

            if (r_h_counter >= h_sync) and (r_h_counter /= h_total) then
                o_hdmi_hs <= '1';
            else
                o_hdmi_hs <= '0';
            end if;

            if (r_h_counter = h_start) then
                r_h_active <= '1';
            elsif (r_h_counter = h_end) then
                r_h_active <= '0';
            end if;
                
        end if;
    end process;
end architecture rtl;
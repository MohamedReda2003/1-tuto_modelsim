
library ieee;
use ieee.std_logic_1164.all;

entity hdmi_controler_tb is
end entity hdmi_controler_tb;

architecture tb of hdmi_controler_tb is

    constant T : time := 10 ns;

    constant H_SYNC  : positive := 61;
    constant H_FP    : positive := 58;
    constant H_RES   : positive := 720;
    constant H_BP    : positive := 18;
    constant H_TOTAL : positive := H_SYNC + H_FP + H_RES + H_BP;

    signal tb_i_clk : std_logic := '0';
    signal tb_i_rst_n : std_logic := '0';

    signal tb_hdmi_hs : std_logic;
    signal tb_hdmi_vs : std_logic;
    signal tb_hdmi_de : std_logic;
    signal tb_pixel_en : std_logic;

    signal tb_pixel_address : natural range 0 to (720 * 480 - 1);
    signal tb_x_counter : natural range 0 to 719;
    signal tb_y_counter : natural range 0 to 479;

    signal tb_done : boolean := false;
begin

    uut : entity work.hdmi_controler
        generic map (
            h_res  => 720,
            v_res  => 480,
            h_sync => H_SYNC,
            h_fp   => H_FP,
            h_bp   => H_BP,
            v_sync => 5,
            v_fp   => 30,
            v_bp   => 9
        )
        port map (
            --- i/o to know inputs and outputs of the unit under test in a testbench
            i_clk           => tb_i_clk,
            i_rst_n         => tb_i_rst_n,
          
            o_hdmi_hs       => tb_hdmi_hs,
            o_hdmi_vs       => tb_hdmi_vs,
            o_hdmi_de       => tb_hdmi_de,
            o_pixel_en      => tb_pixel_en,
            o_pixel_address => tb_pixel_address,
            o_x_counter     => tb_x_counter,
            o_y_counter     => tb_y_counter
        );

    -- Génération de l'horloge
    clock_process : process
    begin
        while not tb_done loop
            tb_i_clk <= '0';
            wait for T / 2;
            tb_i_clk <= '1';
            wait for T / 2;
        end loop;
        wait;
    end process;

    -- Stimuli et vérification
    test_process : process
        variable expected_hs : std_logic;
    begin
        -- Maintien du reset
        tb_i_rst_n <= '0';
        wait for 3 * T;

        -- Désactivation du reset
        tb_i_rst_n <= '1';

        -- Vérification d'une ligne horizontale complète
        for counter in 0 to H_TOTAL loop

            wait until rising_edge(tb_i_clk);
            wait for 1 ns;

            if counter >= H_SYNC and counter /= H_TOTAL then
                expected_hs := '1';
            else
                expected_hs := '0';
            end if;

            assert tb_hdmi_hs = expected_hs
                report "Erreur sur o_hdmi_hs au compteur "
                        & integer'image(counter)
                severity error;
        end loop;

        report "Test horizontal terminé avec succès."
            severity note;
        tb_done <= true;
        wait;
    end process;

end architecture tb;
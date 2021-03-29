-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 29.3.2021 18:00:18 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_cpt_export_grille is
end tb_cpt_export_grille;

architecture tb of tb_cpt_export_grille is

    component cpt_export_grille
        port (clk      : in std_logic;
              rst      : in std_logic;
              CE       : in std_logic;
              cpt_en   : in std_logic;
              addr_max : out std_logic;
              addr     : out std_logic_vector (3 downto 0));
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal CE       : std_logic;
    signal cpt_en   : std_logic;
    signal addr_max : std_logic;
    signal addr     : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : cpt_export_grille
    port map (clk      => clk,
              rst      => rst,
              CE       => CE,
              cpt_en   => cpt_en,
              addr_max => addr_max,
              addr     => addr);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '1';
        cpt_en <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 1 * TbPeriod;
        cpt_en <= '1';
        wait for 16 * TbPeriod;
        cpt_en <= '0';
        wait for 3 * TbPeriod;
        cpt_en <= '1';
        wait for 16 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_cpt_export_grille of tb_cpt_export_grille is
    for tb
    end for;
end cfg_tb_cpt_export_grille;
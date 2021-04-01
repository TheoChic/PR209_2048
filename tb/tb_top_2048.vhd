-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 1.4.2021 16:32:55 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Top_2048 is
end tb_Top_2048;

architecture tb of tb_Top_2048 is

    component Top_2048
        port (clk        : in std_logic;
              rst        : in std_logic;
              btn_haut   : in std_logic;
              btn_bas    : in std_logic;
              btn_droit  : in std_logic;
              btn_gauche : in std_logic;
              VGA_hs     : out std_logic;
              VGA_vs     : out std_logic;
              VGA_red    : out std_logic_vector (3 downto 0);
              VGA_green  : out std_logic_vector (3 downto 0);
              VGA_blue   : out std_logic_vector (3 downto 0));
    end component;

    signal clk        : std_logic;
    signal rst        : std_logic;
    signal btn_haut   : std_logic;
    signal btn_bas    : std_logic;
    signal btn_droit  : std_logic;
    signal btn_gauche : std_logic;
    signal VGA_hs     : std_logic;
    signal VGA_vs     : std_logic;
    signal VGA_red    : std_logic_vector (3 downto 0);
    signal VGA_green  : std_logic_vector (3 downto 0);
    signal VGA_blue   : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Top_2048
    port map (clk        => clk,
              rst        => rst,
              btn_haut   => btn_haut,
              btn_bas    => btn_bas,
              btn_droit  => btn_droit,
              btn_gauche => btn_gauche,
              VGA_hs     => VGA_hs,
              VGA_vs     => VGA_vs,
              VGA_red    => VGA_red,
              VGA_green  => VGA_green,
              VGA_blue   => VGA_blue);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        btn_haut <= '0';
        btn_bas <= '0';
        btn_droit <= '0';
        btn_gauche <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;

        wait for 100 * TbPeriod;
        btn_haut <= '1';
        wait for 1 * TbPeriod;
        btn_haut <= '0';

        -- EDIT Add stimuli here
        wait for 100000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Top_2048 of tb_Top_2048 is
    for tb
    end for;
end cfg_tb_Top_2048;
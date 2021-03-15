-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 15.3.2021 15:14:36 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_processeur is
end tb_processeur;

architecture tb of tb_processeur is

    component processeur
        port (clk        : in std_logic;
              rst        : in std_logic;
              CE         : in std_logic;
              btn_haut   : in std_logic;
              btn_bas    : in std_logic;
              btn_droit  : in std_logic;
              btn_gauche : in std_logic;
              value      : out std_logic_vector (255 downto 0));
    end component;

    signal clk        : std_logic;
    signal rst        : std_logic;
    signal CE         : std_logic;
    signal btn_haut   : std_logic;
    signal btn_bas    : std_logic;
    signal btn_droit  : std_logic;
    signal btn_gauche : std_logic;
    signal value      : std_logic_vector (255 downto 0);
    
    SIGNAL cpt_enable, cpt_init : STD_LOGIC;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    

    dut : processeur
    port map (clk        => clk,
              rst        => rst,
              CE         => CE,
              btn_haut   => btn_haut,
              btn_bas    => btn_bas,
              btn_droit  => btn_droit,
              btn_gauche => btn_gauche,
              value      => value);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '0';
        btn_haut <= '0';
        btn_bas <= '0';
        btn_droit <= '0';
        btn_gauche <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        
        -- EDIT Add stimuli here
        wait for 1 * TbPeriod;
        CE <= '1';
        cpt_init <= '1';
        cpt_enable <= '1';
        
        wait for 1 * TbPeriod;
        CE <= '1';
        cpt_init <= '0';
        cpt_enable <= '0';
        
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_processeur of tb_processeur is
    for tb
    end for;
end cfg_tb_processeur;
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 15.3.2021 14:09:34 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_machine_etats is
end tb_machine_etats;

architecture tb of tb_machine_etats is

    component machine_etats
        port (CLK          : in std_logic;
              RST          : in std_logic;
              CE           : in std_logic;
              btn_haut     : in std_logic;
              btn_bas      : in std_logic;
              btn_droit    : in std_logic;
              btn_gauche   : in std_logic;
              index_grille : in std_logic_vector (3 downto 0);
              cpt_init     : out std_logic;
              value        : out std_logic_vector (255 downto 0));
    end component;

    signal CLK          : std_logic;
    signal RST          : std_logic;
    signal CE           : std_logic;
    signal btn_haut     : std_logic;
    signal btn_bas      : std_logic;
    signal btn_droit    : std_logic;
    signal btn_gauche   : std_logic;
    signal index_grille : std_logic_vector (3 downto 0);
    signal cpt_init     : std_logic;
    signal value        : std_logic_vector (255 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : machine_etats
    port map (CLK          => CLK,
              RST          => RST,
              CE           => CE,
              btn_haut     => btn_haut,
              btn_bas      => btn_bas,
              btn_droit    => btn_droit,
              btn_gauche   => btn_gauche,
              index_grille => index_grille,
              cpt_init     => cpt_init,
              value        => value);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '0';
        btn_haut <= '0';
        btn_bas <= '0';
        btn_droit <= '0';
        btn_gauche <= '0';
        index_grille <= (others => '0');

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 1 * TbPeriod;
        btn_haut <= '1';
        wait for 1 * TbPeriod;
        btn_haut <= '0';

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_machine_etats of tb_machine_etats is
    for tb
    end for;
end cfg_tb_machine_etats;
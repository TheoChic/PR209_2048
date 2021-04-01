-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 15.3.2021 14:57:20 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_pulse_limiter is
end tb_pulse_limiter;

architecture tb of tb_pulse_limiter is

    component pulse_limiter
        port (CLK         : in std_logic;
              RST         : in std_logic;
              CE          : in std_logic;
              btn_haut    : in std_logic;
              btn_bas     : in std_logic;
              btn_droit   : in std_logic;
              btn_gauche  : in std_logic;
              haut   : out std_logic;
              bas    : out std_logic;
              droit  : out std_logic;
              gauche : out std_logic);
    end component;

    signal CLK         : std_logic;
    signal RST         : std_logic;
    signal CE          : std_logic;
    signal btn_haut    : std_logic;
    signal btn_bas     : std_logic;
    signal btn_droit   : std_logic;
    signal btn_gauche  : std_logic;
    signal etat_haut   : std_logic;
    signal etat_bas    : std_logic;
    signal etat_droit  : std_logic;
    signal etat_gauche : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : pulse_limiter
    port map (CLK         => CLK,
              RST         => RST,
              CE          => CE,
              btn_haut    => btn_haut,
              btn_bas     => btn_bas,
              btn_droit   => btn_droit,
              btn_gauche  => btn_gauche,
              haut   => etat_haut,
              bas    => etat_bas,
              droit  => etat_droit,
              gauche => etat_gauche);

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

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        CE <= '1';
        wait for 1 * TbPeriod;
        btn_haut <= '1';
        wait for 15 * TbPeriod;
        btn_bas <= '1';
        btn_haut <= '1';
        wait for 15 * TbPeriod;
        btn_droit <= '1';
        btn_bas <= '0';
        wait for 15 * TbPeriod;
        btn_gauche <= '1';
        btn_droit <= '0';
        wait for 15 * TbPeriod;
        btn_gauche <= '0';
        wait for 5 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_pulse_limiter of tb_pulse_limiter is
    for tb
    end for;
end cfg_tb_pulse_limiter;
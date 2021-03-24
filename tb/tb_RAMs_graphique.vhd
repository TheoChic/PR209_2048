-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 11.3.2021 15:15:10 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_RAMs_graphique is
end tb_RAMs_graphique;

architecture tb of tb_RAMs_graphique is

    component RAMs_graphique
        port (clk        : in std_logic;
              rst        : in std_logic;
              CE         : in std_logic;
              enable_mem : in std_logic;
              enable_cpt : in std_logic;
              cpt_init   : in std_logic;
              adr_out    : out std_logic_vector (10 downto 0);
              RAM_0      : out std_logic_vector (7 downto 0);
              RAM_2      : out std_logic_vector (7 downto 0);
              RAM_4      : out std_logic_vector (7 downto 0);
              RAM_8      : out std_logic_vector (7 downto 0);
              RAM_16     : out std_logic_vector (7 downto 0);
              RAM_32     : out std_logic_vector (7 downto 0);
              RAM_64     : out std_logic_vector (7 downto 0);
              RAM_128    : out std_logic_vector (7 downto 0);
              RAM_256    : out std_logic_vector (7 downto 0);
              RAM_512    : out std_logic_vector (7 downto 0);
              RAM_1024   : out std_logic_vector (7 downto 0);
              RAM_2048   : out std_logic_vector (7 downto 0));
    end component;

    signal clk        : std_logic;
    signal rst        : std_logic;
    signal CE         : std_logic;
    signal enable_mem : std_logic;
    signal enable_cpt : std_logic;
    signal cpt_init   : std_logic;
    signal adr_out    : std_logic_vector (10 downto 0);
    signal RAM_0      : std_logic_vector (7 downto 0);
    signal RAM_2      : std_logic_vector (7 downto 0);
    signal RAM_4      : std_logic_vector (7 downto 0);
    signal RAM_8      : std_logic_vector (7 downto 0);
    signal RAM_16     : std_logic_vector (7 downto 0);
    signal RAM_32     : std_logic_vector (7 downto 0);
    signal RAM_64     : std_logic_vector (7 downto 0);
    signal RAM_128    : std_logic_vector (7 downto 0);
    signal RAM_256    : std_logic_vector (7 downto 0);
    signal RAM_512    : std_logic_vector (7 downto 0);
    signal RAM_1024   : std_logic_vector (7 downto 0);
    signal RAM_2048   : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : RAMs_graphique
    port map (clk        => clk,
              rst        => rst,
              CE         => CE,
              enable_mem => enable_mem,
              enable_cpt => enable_cpt,
              cpt_init   => cpt_init,
              adr_out    => adr_out,
              RAM_0      => RAM_0,
              RAM_2      => RAM_2,
              RAM_4      => RAM_4,
              RAM_8      => RAM_8,
              RAM_16     => RAM_16,
              RAM_32     => RAM_32,
              RAM_64     => RAM_64,
              RAM_128    => RAM_128,
              RAM_256    => RAM_256,
              RAM_512    => RAM_512,
              RAM_1024   => RAM_1024,
              RAM_2048   => RAM_2048);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed


        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

    CE <= '1';
    enable_mem <= '1';
    enable_cpt <= '1';
    cpt_init <= '0';

end tb;
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.3.2021 18:56:25 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_conv_grid_to_img is
end tb_conv_grid_to_img;

architecture tb of tb_conv_grid_to_img is

    component conv_grid_to_img
        port (clk               : in std_logic;
              rst               : in std_logic;
              CE                : in std_logic;
              index_in          : in std_logic_vector (3 downto 0);
              value_in          : in std_logic_vector (11 downto 0);
              enable_mem        : in STD_LOGIC;
              enable_cpt        : in STD_LOGIC;
              init_cpt_addr_ram : in std_logic;
              init_adresseur    : in std_logic;
              data_out          : out std_logic_vector (7 downto 0);
              addr_out          : out std_logic_vector (13 downto 0));
    end component;

    signal clk               : std_logic;
    signal rst               : std_logic;
    signal CE                : std_logic;
    signal index_in          : std_logic_vector (3 downto 0);
    signal value_in          : std_logic_vector (11 downto 0);
    signal enable_mem        : STD_LOGIC;
    signal enable_cpt        : STD_LOGIC;
    signal init_cpt_addr_ram : std_logic;
    signal init_adresseur    : std_logic;
    signal data_out          : std_logic_vector (7 downto 0);
    signal addr_out          : std_logic_vector (13 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : conv_grid_to_img
    port map (clk               => clk,
              rst               => rst,
              CE                => CE,
              index_in          => index_in,
              value_in          => value_in,
              enable_mem        => enable_mem,
              enable_cpt        => enable_cpt,
              init_cpt_addr_ram => init_cpt_addr_ram,
              init_adresseur    => init_adresseur,
              data_out          => data_out,
              addr_out          => addr_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed


        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        
        -- EDIT Add stimuli here
        index_in <= "0000";
        value_in <= "000000000010";

        wait for 1500 * TbPeriod;
        index_in <= "0100";
        value_in <= "000000000100";

        wait for 1500 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;


    CE <= '1';
    enable_mem <= '1';
    enable_cpt <= '1';
    init_cpt_addr_ram <= '0';
    init_adresseur <= '0';
end tb;
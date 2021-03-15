-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.3.2021 11:27:29 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_cpt_4bits is
end tb_cpt_4bits;

architecture tb of tb_cpt_4bits is

    component cpt_4bits
        port (clk        : in std_logic;
              rst        : in std_logic;
              CE         : in std_logic;
              cpt_enable : in std_logic;
              cpt_init   : in std_logic;
              cpt_value  : out std_logic_vector (3 downto 0));
    end component;

    signal clk        : std_logic;
    signal rst        : std_logic;
    signal CE         : std_logic;
    signal cpt_enable : std_logic;
    signal cpt_init   : std_logic;
    signal cpt_value  : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : cpt_4bits
    port map (clk        => clk,
              rst        => rst,
              CE         => CE,
              cpt_enable => cpt_enable,
              cpt_init   => cpt_init,
              cpt_value  => cpt_value);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '0';
        cpt_enable <= '0';
        cpt_init <= '0';

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
        
        cpt_init <= '1';
        
        wait for 1 * TbPeriod; cpt_enable <= '1'; cpt_init <= '0'; wait for 1 * TbPeriod; cpt_enable <= '0';   
        
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        wait for 1 * TbPeriod; cpt_enable <= '1'; wait for 1 * TbPeriod; cpt_enable <= '0';
        
        wait for 1 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;
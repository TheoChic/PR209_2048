-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 24.3.2021 09:41:47 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_cpt_4bits is
end tb_cpt_4bits;

architecture tb of tb_cpt_4bits is

    component cpt_4bits
        port (clk       : in std_logic;
              rst       : in std_logic;
              CE        : in std_logic;
              cpt_en    : in std_logic;
              cpt_init  : in std_logic;
              val_btn   : in std_logic_vector (1 downto 0);
              addr_max  : out std_logic;
              ind_i     : out std_logic_vector (1 downto 0);
              ind_j     : out std_logic_vector (1 downto 0);
              pr_addr   : out std_logic_vector (3 downto 0);
              curr_addr : out std_logic_vector (3 downto 0);
              nx_addr   : out std_logic_vector (3 downto 0));
    end component;

    signal clk       : std_logic;
    signal rst       : std_logic;
    signal CE        : std_logic;
    signal cpt_en    : std_logic;
    signal cpt_init  : std_logic;
    signal val_btn   : std_logic_vector (1 downto 0);
    signal addr_max  : std_logic;
    signal ind_i     : std_logic_vector (1 downto 0);
    signal ind_j     : std_logic_vector (1 downto 0);
    signal pr_addr   : std_logic_vector (3 downto 0);
    signal curr_addr : std_logic_vector (3 downto 0);
    signal nx_addr   : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : cpt_4bits
    port map (clk       => clk,
              rst       => rst,
              CE        => CE,
              cpt_en    => cpt_en,
              cpt_init  => cpt_init,
              val_btn   => val_btn,
              addr_max  => addr_max,
              ind_i     => ind_i,
              ind_j     => ind_j,
              pr_addr   => pr_addr,
              curr_addr => curr_addr,
              nx_addr   => nx_addr);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '0';
        cpt_en <= '0';
        cpt_init <= '0';
        val_btn <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        cpt_init <= '0';
        cpt_en <= '1';
        val_btn <= "11";
              
        wait for 1 * TbPeriod; CE <= '1';    
        cpt_init <= '1';            
        wait for 1 * TbPeriod; CE <= '0';
        cpt_init <= '0';  
             
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';
        
        wait for 1 * TbPeriod; CE <= '1';
        wait for 1 * TbPeriod; CE <= '0';                                                                                

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_cpt_4bits of tb_cpt_4bits is
    for tb
    end for;
end cfg_tb_cpt_4bits;
-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 1.4.2021 22:37:16 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_cpt_4bits is
end tb_cpt_4bits;

architecture tb of tb_cpt_4bits is

    component cpt_4bits
        port (clk          : in std_logic;
              rst          : in std_logic;
              CE           : in std_logic;
              cpt_en       : in std_logic;
              cpt_init     : in std_logic;
              val_btn      : in std_logic_vector (3 downto 0);
              val_btn_init : in std_logic;
              rst_b        : in std_logic;
              addr_max     : out std_logic;
              pr_addr      : out std_logic_vector (3 downto 0);
              curr_addr    : out std_logic_vector (3 downto 0);
              nx_addr      : out std_logic_vector (3 downto 0));
    end component;

    signal clk          : std_logic;
    signal rst          : std_logic;
    signal CE           : std_logic;
    signal cpt_en       : std_logic;
    signal cpt_init     : std_logic;
    signal val_btn      : std_logic_vector (3 downto 0);
    signal val_btn_init : std_logic;
    signal rst_b        : std_logic;
    signal addr_max     : std_logic;
    signal pr_addr      : std_logic_vector (3 downto 0);
    signal curr_addr    : std_logic_vector (3 downto 0);
    signal nx_addr      : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : cpt_4bits
    port map (clk          => clk,
              rst          => rst,
              CE           => CE,
              cpt_en       => cpt_en,
              cpt_init     => cpt_init,
              val_btn      => val_btn,
              val_btn_init => val_btn_init,
              rst_b        => rst_b,
              addr_max     => addr_max,
              pr_addr      => pr_addr,
              curr_addr    => curr_addr,
              nx_addr      => nx_addr);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '1';
        cpt_en <= '0';
        cpt_init <= '0';
        val_btn <= (others => '0');
        val_btn_init <= '0';
        rst_b <= '0';

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '0';
        wait for 100 ns;
        rst <= '1';
        wait for 100 ns;
        
        wait for 1 * TbPeriod;
        cpt_en <= '1'; 
              
        wait for 1 * TbPeriod;    
        rst_b <= '1';            
        wait for 1 * TbPeriod;
        rst_b <= '0';  

        
        wait for 2 * TbPeriod;    
        cpt_init <= '1';            
        wait for 1 * TbPeriod;
        cpt_init <= '0';  

        val_btn <= "1000";
        
        wait for 1 * TbPeriod;
        rst_b <= '0';
        wait for 18 * TbPeriod;

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

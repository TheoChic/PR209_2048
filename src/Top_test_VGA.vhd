----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2021 13:23:11
-- Design Name: 
-- Module Name: Top_VGA - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_VGA is
    generic (   cpt_addr_max    : integer := 15999;
                bit_per_pixel   : integer range 1 to 12 := 1
            );
    Port (  clk     : in STD_LOGIC;
            rst     : in STD_LOGIC;
            VGA_hs       : out STD_LOGIC;   -- horisontal vga syncr.
            VGA_vs       : out STD_LOGIC;   -- vertical vga syncr.
            VGA_red      : out STD_LOGIC_VECTOR(3 downto 0);   -- red output
            VGA_green    : out STD_LOGIC_VECTOR(3 downto 0);   -- green output
            VGA_blue     : out STD_LOGIC_VECTOR(3 downto 0)    -- blue output
            );
end Top_VGA;

architecture Behavioral of Top_VGA is

component VGA_bitmap_160x100
    generic(    bit_per_pixel : integer range 1 to 12:=1;    -- number of bits per pixel
                grayscale     : boolean := false);
                
	port ( clk          : in  std_logic;
           reset        : in  std_logic;
           VGA_hs       : out std_logic;   -- horisontal vga syncr.
           VGA_vs       : out std_logic;   -- vertical vga syncr.
           VGA_red      : out std_logic_vector(3 downto 0);   -- red output
           VGA_green    : out std_logic_vector(3 downto 0);   -- green output
           VGA_blue     : out std_logic_vector(3 downto 0);   -- blue output
    
           ADDR         : in  std_logic_vector(13 downto 0);
           data_in      : in  std_logic_vector(bit_per_pixel - 1 downto 0);
           data_write   : in  std_logic;
           data_out     : out std_logic_vector(bit_per_pixel - 1 downto 0));
end component;


SIGNAL sig_addr : STD_LOGIC_VECTOR(13 downto 0);
SIGNAL sig_data_in, sig_data_out : STD_LOGIC_VECTOR(bit_per_pixel - 1 downto 0);

SIGNAL cpt_addr : integer range 0 to cpt_addr_max := 0;

begin

VGA : VGA_bitmap_160x100 
    generic map( bit_per_pixel, FALSE)
    
    port map(   clk     => clk,
                reset   => rst,
                VGA_hs  => VGA_hs,        
                VGA_vs  => VGA_vs,        
                VGA_red => VGA_red, 
                VGA_green   => VGA_green, 
                VGA_blue    => VGA_blue,
                ADDR    => sig_addr,
                data_in => sig_data_in,
                data_write  => '1',
                data_out    => sig_data_out                
                );                  

    process(clk, rst)
        begin
        if (rst = '0') then
            cpt_addr <= 0;
            
        elsif( clk'event and clk = '1') then  
            cpt_addr <= cpt_addr + 1;
            if (cpt_addr = cpt_addr_max) then
                cpt_addr <= 0;
  
            end if; 
    
            sig_data_in <= (others => '1');


        end if; 
        
    end process;
    
    sig_addr <= STD_LOGIC_VECTOR(to_unsigned(cpt_addr,14));      
end Behavioral;

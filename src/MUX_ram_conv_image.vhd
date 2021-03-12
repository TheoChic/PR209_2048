----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2021 14:38:55
-- Design Name: 
-- Module Name: MUX - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX_ram_conv_image is
    Port ( SEL          :   in      STD_LOGIC_VECTOR (11 downto 0);
           data_in_0    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_2    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_4    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_8    :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_16   :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_32   :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_64   :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_128  :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_256  :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_512  :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_1024 :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_in_2048 :   in      STD_LOGIC_VECTOR (7 downto 0);
           data_out     :   out     STD_LOGIC_VECTOR (7 downto 0)
           );
end MUX_ram_conv_image;

architecture RTL of MUX_ram_conv_image is

begin

    process(SEL, data_in_0, data_in_2, data_in_4, data_in_8, data_in_16, data_in_32, data_in_64, data_in_128, data_in_256, data_in_512, data_in_1024, data_in_2048)
    begin
        case SEL is
            when "000000000000" =>  data_out <= data_in_0;
            when "000000000010" =>  data_out <= data_in_2;
            when "000000000100" =>  data_out <= data_in_4;
            when "000000001000" =>  data_out <= data_in_8;
            when "000000010000" =>  data_out <= data_in_16;
            when "000000100000" =>  data_out <= data_in_32;
            when "000001000000" =>  data_out <= data_in_64;
            when "000010000000" =>  data_out <= data_in_128;
            when "000100000000" =>  data_out <= data_in_256;
            when "001000000000" =>  data_out <= data_in_512;
            when "010000000000" =>  data_out <= data_in_1024;
            when "100000000000" =>  data_out <= data_in_2048;
            when others =>  data_out <= data_in_0;
        end case;
    end process;
end RTL;

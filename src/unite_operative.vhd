----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2021 22:25:56
-- Design Name: 
-- Module Name: unite_operative - Behavioral
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

entity unite_operative is
    Port(   c1, c2      : in STD_LOGIC_VECTOR (11 downto 0);
            en_add      : in STD_LOGIC;
            cmp, zero   : out STD_LOGIC;
            add         : out STD_LOGIC_VECTOR (11 downto 0));
end unite_operative;

architecture beh_unite_operative of unite_operative is

component comparateur_12_bits is
    Port ( c1, c2       : in STD_LOGIC_VECTOR (11 downto 0);
           cmp, zero    : out STD_LOGIC);
end component;

component additionneur_12_bits is
    Port ( c1, c2   : in STD_LOGIC_VECTOR (11 downto 0);
           en_add   : in STD_LOGIC;
           add      : out STD_LOGIC_VECTOR (11 downto 0));
end component;

begin
        
comp : comparateur_12_bits
port map(   c1      =>  c1,
            c2      =>  c2,
            cmp     =>  cmp,
            zero    => zero);
            
add1 : additionneur_12_bits
port map(   c1      => c1, 
            c2      => c2,
            en_add  => en_add,
            add     => add); 

end beh_unite_operative;

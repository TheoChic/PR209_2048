library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparateur_12_bits is
    Port ( c1, c2       : in STD_LOGIC_VECTOR (11 downto 0);
           cmp, zero    : out STD_LOGIC);
end comparateur_12_bits;

architecture beh_comparateur_12_bits of comparateur_12_bits is

begin
    cmp <= '1' when c1(11 downto 0) = c2(11 downto 0) else '0';
    zero <= '1' when c1 = "000000000000" else '0';

end beh_comparateur_12_bits;

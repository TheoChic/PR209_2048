library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pulse_limiter is
  Port (   CLK, RST, CE : IN STD_LOGIC;

	       btn_haut     : IN STD_LOGIC;
           btn_bas      : IN STD_LOGIC;
	       btn_droit    : IN STD_LOGIC;
	       btn_gauche   : IN STD_LOGIC;

           haut         : OUT STD_LOGIC;
           droit        : OUT STD_LOGIC;
	       bas  	    : OUT STD_LOGIC;
	       gauche 	    : OUT STD_LOGIC);
end pulse_limiter;

architecture beh_pulse_limiter of pulse_limiter is

signal flag : std_logic_vector(3 downto 0);

begin
p1 : process ( CLK , RST )
    begin
        if ( RST = '1' or btn_haut = '0') then
            flag(0) <= '0';
            haut <= '0';
        elsif ( CLK'event and CLK  = '1' and CE = '1') then
            if(flag(0) = '0' and btn_haut = '1') then
                 haut <= '1';
                 flag(0) <= '1';
            else
                haut <= '0';
            end if;
        end if;
end process p1;

p2 : process ( CLK , RST )
    begin
        if ( RST = '1' or btn_bas = '0') then
            flag(1) <= '0';
            bas <= '0';
        elsif ( CLK'event and CLK = '1' and CE = '1') then
            if (flag(1) = '0' and btn_bas = '1') then
                bas <= '1';
                flag(1) <= '1';
            else
                bas <= '0';
            end if;
        end if;
end process p2;

p3 : process ( CLK , RST )
    begin
        if ( RST = '1' or btn_droit = '0') then
            flag(2) <= '0';
            droit <= '0';
        elsif ( CLK'event and CLK = '1' and CE = '1') then
            if (flag(2) = '0' and btn_droit = '1') then
                droit <= '1';
                flag(2) <= '1';
            else
                droit <= '0';
            end if;
        end if;
end process p3;

p4 : process ( CLK , RST )
    begin
        if ( RST = '1' or btn_gauche = '0') then
            flag(3) <= '0';
            gauche <= '0';
        elsif ( CLK'event and CLK = '1' and CE = '1') then
            if (flag(3) = '0' and btn_gauche = '1') then
                gauche <= '1';
                flag(3) <= '1';
            else
                gauche <= '0';
            end if;
        end if;
end process p4;

end beh_pulse_limiter;
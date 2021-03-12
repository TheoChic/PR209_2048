-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.3.2021 09:51:48 UTC

library ieee;
use ieee.std_logic_1164.all;
use IEEE . NUMERIC_STD.ALL ;


entity tb_adresseur is
end tb_adresseur;

architecture tb of tb_adresseur is

    component adresseur
        port (clk         : in std_logic;
              rst         : in std_logic;
              init         : in STD_LOGIC;

              index       : in std_logic_vector (3 downto 0);
              addr_ram    : in std_logic_vector (8 downto 0);
              addr_screen : out std_logic_vector (13 downto 0));
    end component;

    signal clk         : std_logic;
    signal rst         : std_logic;
    signal index       : std_logic_vector (3 downto 0);
    signal addr_ram    : std_logic_vector (8 downto 0);
    signal addr_screen : std_logic_vector (13 downto 0);
    signal             init         :  STD_LOGIC;

        
    signal cmp : unsigned (8 downto 0) := "000000000";

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : adresseur
    port map (clk         => clk,
              rst         => rst,
              init        => init,
              index       => index,
              addr_ram    => addr_ram,
              addr_screen => addr_screen);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        index <= (others => '0');
        init <= '0';
        -- EDIT Add stimuli here
        wait for 1950 * TbPeriod;
        index <= "0100";
        wait for 4000 * TbPeriod;
        
        wait for 4010 * TbPeriod;
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

    process(TbClock)
        begin
        if(TbClock'event and TbClock='1') then 
            if (cmp = "110001111") then
                cmp <= "000000000";
            else cmp <= cmp + 1;end if;
        end if;
    end process;
    
    addr_ram <= std_logic_vector(cmp);

end tb;


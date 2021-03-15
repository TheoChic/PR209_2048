library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL ;


entity processeur is
    Port ( clk, rst, CE	: IN STD_LOGIC;
	       btn_haut     : IN STD_LOGIC;
           btn_bas      : IN STD_LOGIC;
	       btn_droit    : IN STD_LOGIC;
	       btn_gauche   : IN STD_LOGIC;
	       
	       value        : OUT STD_LOGIC_VECTOR(255 DOWNTO 0));
end processeur;

architecture beh_processeur of processeur is


component pulse_limiter is
    Port ( CLK, RST, CE : IN STD_LOGIC;

	       btn_haut     : IN STD_LOGIC;
           btn_bas      : IN STD_LOGIC;
	       btn_droit    : IN STD_LOGIC;
	       btn_gauche   : IN STD_LOGIC;

           etat_haut    : OUT STD_LOGIC;
           etat_bas     : OUT STD_LOGIC;
	       etat_droit 	: OUT STD_LOGIC;
	       etat_gauche 	: OUT STD_LOGIC);
END COMPONENT;

component cpt_4bits is
    Port ( clk, rst, CE : IN  STD_LOGIC;
           cpt_enable   : IN  STD_LOGIC;
           cpt_init     : IN  STD_LOGIC;
           cpt_value    : OUT STD_LOGIC_VECTOR (3 downto 0));
end component;

component machine_etats is
  Port (   CLK, RST, CE	: IN STD_LOGIC;
	       
	       btn_haut     : IN STD_LOGIC;
	       btn_bas      : IN STD_LOGIC;
	       btn_droit    : IN STD_LOGIC;
	       btn_gauche   : IN STD_LOGIC;
	       
	       index_grille : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	       cpt_init     : OUT STD_LOGIC;	              
           
           value        : OUT STD_LOGIC_VECTOR(255 DOWNTO 0));
end component;

SIGNAL haut, bas, droit, gauche : STD_LOGIC;
SIGNAL cpt_enable, cpt_init : STD_LOGIC;
SIGNAL cpt_value : STD_LOGIC_VECTOR (3 downto 0);

begin

appui : pulse_limiter
    PORT MAP(   CLK => CLK,
                RST => RST,
                CE => CE,

	            btn_haut => btn_haut,
                btn_bas => btn_bas,
                btn_droit => btn_droit,
                btn_gauche => btn_gauche,
                
                etat_haut => haut,
                etat_bas => bas,
	            etat_droit => droit,
                etat_gauche => gauche);
                
                
index_grille : cpt_4bits
    PORT MAP(   CLK => CLK,
                RST => RST,
                CE => CE,
                
	            cpt_enable => cpt_enable,
	            cpt_init => cpt_init,
	            cpt_value => cpt_value); 
	            
algo_jeu : machine_etats
    port map(   CLK => CLK,
                RST => RST,
                CE => CE,
                
                btn_haut => haut,
                btn_bas => bas,
                btn_droit => droit,
                btn_gauche => gauche,
                
                index_grille => cpt_value,
                cpt_init => cpt_init,
                value =>  value); 	            
	                            
end beh_processeur;



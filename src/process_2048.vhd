----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2021 15:52:54
-- Design Name: 
-- Module Name: process_2048 - beh_process_2048
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

entity process_2048 is
  Port (   CLK, RST, CE             : in std_logic;

	       btn_haut                 : in std_logic;
           btn_bas                  : in std_logic;
	       btn_droit                : in std_logic;
	       btn_gauche               : in std_logic);
end process_2048;

architecture beh_process_2048 of process_2048 is

-- SIGNAUX COMPTEUR
signal val_btn                      : std_logic_vector (1 downto 0);
signal pr_addr, curr_addr, nx_addr  : std_logic_vector (3 downto 0);
signal addr_max                     : std_logic;
signal ind_i, ind_j                 : std_logic_vector (1 downto 0); 

-- SIGNAUX PULSE LIMITER
signal haut, bas, droit, gauche     : std_logic;

-- SIGNAUX RAM grille
signal addr_w, addr_r               : std_logic_vector(3 downto 0);
signal data_in, data_out            : std_logic_vector(11 downto 0);

signal data_out_pr                  : std_logic_vector(11 downto 0);

-- SIGNAUX FSM
signal cpt_en, cpt_init             : std_logic;

signal sel_addr, sel_addw           : std_logic;
signal write_en                     : std_logic;

signal zero, cmp                    : std_logic;
signal add                          : std_logic_vector(11 downto 0);

signal add_en                       : std_logic;

signal sel_dataw                    : std_logic_vector(1 downto 0);

component pulse_limiter is
  Port (   CLK, RST, CE             : in std_logic;

	       btn_haut                 : in std_logic;
           btn_bas                  : in std_logic;
	       btn_droit                : in std_logic;
	       btn_gauche               : in std_logic;

           haut                     : OUT STD_LOGIC;
           droit                    : OUT STD_LOGIC;
	       bas  	                : OUT STD_LOGIC;
	       gauche 	                : OUT STD_LOGIC);
end component;

component mux_4_entrees is
    Port ( e0, e1, e2, e3           : in std_logic_vector (1 downto 0);
           sel                      : in std_logic_vector (3 downto 0);
           y                        : out std_logic_vector (1 downto 0));
end component;

component cpt_4bits is
    Port ( clk, rst, CE             : in std_logic;
           cpt_en, cpt_init         : in std_logic;
           
           val_btn                  : in  std_logic_vector (1 downto 0);
           
           addr_max                 : out STD_LOGIC;
           ind_i, ind_j             : out std_logic_vector (1 downto 0);             
           pr_addr, curr_addr, nx_addr  :   out std_logic_vector (3 downto 0));
end component;

component mux_2_entrees is
    Port ( e0, e1                   : in STD_LOGIC_VECTOR (3 downto 0);
           sel                      : in STD_LOGIC;
           y                        : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component mux_3_entrees is
    Port ( e0, e1, e2               : in STD_LOGIC_VECTOR (11 downto 0);
           sel                      : in STD_LOGIC_VECTOR (1 downto 0);
           y                        : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component bascule_d is
    Port ( clk : in STD_LOGIC;
           d : in STD_LOGIC_VECTOR (11 downto 0);
           q : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component RAM_double_acces is
    Port ( clk                      : in std_logic;
           CE                       : in std_logic;
           enable_writing           : in std_logic;
           
           adr_out                  : in STD_LOGIC_VECTOR(3 downto 0);
           adr_in                   : in STD_LOGIC_VECTOR(3 downto 0);
           
           data_in                  : in STD_LOGIC_VECTOR(11 downto 0);
           data_out                 : out STD_LOGIC_VECTOR(11 downto 0));
end component;

component unite_operative is
    Port(   c1, c2                  : in STD_LOGIC_VECTOR (11 downto 0);
            en_add                  : in STD_LOGIC;
            cmp, zero               : out STD_LOGIC;
            add                     : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component machine_etats is
  Port (    CLK, RST, CE            : in std_logic;
                       
            ind_i, ind_j            : in std_logic_vector (1 downto 0);       
            cmp, zero               : in std_logic;
            
            addr_max                : in std_logic;
            
            add_en                  : out std_logic;
            cpt_en, cpt_init        : out std_logic;
            w_en                    : out std_logic;
            
            sel_addr, sel_addw      : out std_logic;
            sel_dataw               : out std_logic_vector(1 downto 0));
end component;

begin

pulse : pulse_limiter
Port map(   clk         => clk,
            rst         => rst,
            CE          => CE,
            btn_haut    => btn_haut,
            btn_bas     => btn_bas,
            btn_droit   => btn_droit,
            btn_gauche  => btn_gauche,
            haut   => haut,
            droit  => droit, 
            bas    => bas,
	        gauche => gauche);

sel_btn : mux_4_entrees
Port map(   e0          => "00",
            e1          => "01",
            e2          => "10",
            e3          => "11",
            sel(0)      => haut,
            sel(1)      => droit,
            sel(2)      => bas,
            sel(3)      => gauche,
            y           => val_btn);	       

cpt : cpt_4bits
Port map(   clk         => clk,
            rst         => rst,
            CE          => CE,
            cpt_en      => cpt_en,
            cpt_init    => cpt_init,
            val_btn     => val_btn,
            addr_max    => addr_max,
            ind_i       => ind_i,
            ind_j       => ind_j,          
            pr_addr     => pr_addr,
            curr_addr   => curr_addr,
            nx_addr     => nx_addr);
            
addw : mux_2_entrees
Port map (  e0          => curr_addr,
            e1          => pr_addr,
            sel         => sel_addw,
            y           => addr_w);

addr : mux_2_entrees
Port map (  e0          => curr_addr,
            e1          => nx_addr,
            sel         => sel_addr,
            y           => addr_r);

grid : RAM_double_acces
Port map (  clk         => clk,
            CE          => CE,
            enable_writing => write_en,
            adr_out     => addr_r,
            adr_in      => addr_w,
            data_in     => data_in,
            data_out    => data_out);
            
reg : bascule_d
Port map(   clk         => clk,
            q           => data_out,
            d           => data_out_pr);   

op : unite_operative
Port map(   c1          => data_out,
            c2          => data_out_pr,                     
            en_add      => add_en,
            cmp         => cmp,
            zero        => zero,
            add         => add); 
            
sel_data_w : mux_3_entrees  
Port map(   e0          => data_out,
            e1          => "000000000000",
            e2          => add,
            sel         => sel_dataw,
            y           => data_in);
            
fsm : machine_etats
Port map(   clk         => clk,
            rst         => rst,
            CE          => CE,
            ind_i       => ind_i,
            ind_j       => ind_j,
            cmp         => cmp,
            zero        => zero,
            addr_max    => addr_max,
            add_en      => add_en,
            cpt_en      => cpt_en,
            cpt_init    => cpt_init,
            w_en        => write_en,
            sel_dataw   => sel_dataw,
            sel_addr    => sel_addr,
            sel_addw    => sel_addw);                          

end beh_process_2048;

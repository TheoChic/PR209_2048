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
	       btn_gauche               : in std_logic;
	       
	       addr_write_export        : out std_logic_vector(3 downto 0);
	       data_out_export          : out std_logic_vector(11 downto 0);
	       w_enable_export          : out std_logic_vector(11 downto 0));
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

-- SIGNAUX RAM export grille
signal cpt_en_export                : std_logic;
signal addr_max_export              : std_logic;

-- SIGNAUX FSM
signal cpt_en, cpt_init             : std_logic;

signal sel_addr, sel_addw           : std_logic;
signal write_en                     : std_logic;

signal zero, cmp                    : std_logic;
signal add                          : std_logic_vector(11 downto 0);

signal add_en                       : std_logic;

signal sel_dataw                    : std_logic_vector(1 downto 0);

signal rst_b                        : std_logic;

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

component RAM_double_acces_grille is
    Port ( clk              : in    STD_LOGIC;
           CE               : in    STD_LOGIC;
           enable_writing   : in    STD_LOGIC;
           
           adr_out          : in    STD_LOGIC_VECTOR(3 downto 0);
           adr_in           : in    STD_LOGIC_VECTOR(3 downto 0);
           adr_read_export  : in    STD_LOGIC_VECTOR(3 downto 0); 
           
           data_in          : in    STD_LOGIC_VECTOR(11 downto 0);
           data_out         : out   STD_LOGIC_VECTOR(11 downto 0);
           data_out_export  : out   STD_LOGIC_VECTOR(11 downto 0));
end component;

component cpt_4bits is
    Port ( clk, rst, CE                 :   in  STD_LOGIC;
           cpt_en, cpt_init             :   in  STD_LOGIC;
           
           val_btn                      :   in  STD_LOGIC_VECTOR (3 downto 0);
           
           rst_b                        :   in std_logic;
           
           addr_max                     :   out STD_LOGIC;
           ind_i, ind_j                 :   out STD_LOGIC_VECTOR (1 downto 0);             
           pr_addr, curr_addr, nx_addr  :   out STD_LOGIC_VECTOR (3 downto 0));
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


component unite_operative is
    Port(   c1, c2                  : in STD_LOGIC_VECTOR (11 downto 0);
            en_add                  : in STD_LOGIC;
            cmp, zero               : out STD_LOGIC;
            add                     : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component machine_etats is
  Port (   CLK, RST, CE            : in STD_LOGIC;
            
           cmp, zero               : in std_logic;
            
           btn                     : in STD_LOGIC;
           init_btn                : out STD_LOGIC;
          
           cpt_ram_grille_en, cpt_ram_grille_init        : out STD_LOGIC;
           addr_max_ram_grille     : in STD_LOGIC;
            
           cpt_ram_ext_en, cpt_ram_ext_init        : out STD_LOGIC;
           addr_max_ram_ext        : in STD_LOGIC;
            
           w_en_ram_grille         : out STD_LOGIC;
           w_en_ram_ext            : out STD_LOGIC;

           sel_addr, sel_addw      : out STD_LOGIC;
           sel_dataw               : out STD_LOGIC_VECTOR(1 downto 0);
           val_btn_init            : out STD_LOGIC);
end component;

component cpt_export_grille is
    Port ( clk, rst, CE :   in  STD_LOGIC;
           cpt_en       :   in  STD_LOGIC;
           addr_max     :   out STD_LOGIC;
           addr         :   out STD_LOGIC_VECTOR (3 downto 0));
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

cpt : cpt_4bits
Port map(   clk         => clk,
            rst         => rst,
            CE          => CE,
            cpt_en      => cpt_en,
            cpt_init    => cpt_init,
            val_btn(0)  => haut,
            val_btn(1)  => droit,
            val_btn(2)  => bas,
            val_btn(3)  => gauche,
            rst_b       => rst_b,
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

grid : RAM_double_acces_grille
Port map (  clk         => clk,
            CE          => CE,
            enable_writing => write_en,
            adr_out     => addr_r,            
            adr_in      => addr_w,
            adr_read_export => adr_read_export,
            data_in     => data_in,
            data_out    => data_out,
            data_out_export => data_out_export);
            
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
            addr_max_export => addr_max_export,
            cpt_en_export => cpt_en_export,
            add_en      => add_en,
            cpt_en      => cpt_en,
            cpt_init    => cpt_init,
            rst_b       => rst_b,
            w_en        => write_en,
            sel_dataw   => sel_dataw,
            sel_addr    => sel_addr,
            sel_addw    => sel_addw); 

cpt_export : cpt_export_grille
Port map(   clk         => clk,
            rst         => rst,
            CE          => CE,
            cpt_en      => cpt_en_export,
            addr_max    => addr_max_export,
            addr        => adr_read_export);               

end beh_process_2048;

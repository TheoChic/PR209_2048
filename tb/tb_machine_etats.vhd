-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 1.4.2021 18:07:20 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_machine_etats is
end tb_machine_etats;

architecture tb of tb_machine_etats is

    component machine_etats
        port (CLK                 : in std_logic;
              RST                 : in std_logic;
              CE                  : in std_logic;
              cmp                 : in std_logic;
              zero                : in std_logic;
              btn_haut            : in std_logic;
              btn_bas             : in std_logic;
              btn_gauche          : in std_logic;
              btn_droit           : in std_logic;
              init_btn            : out std_logic;
              cpt_ram_grille_en   : out std_logic;
              cpt_ram_grille_init : out std_logic;
              addr_max_ram_grille : in std_logic;
              cpt_ram_ext_en      : out std_logic;
              cpt_ram_ext_init    : out std_logic;
              addr_max_ram_ext    : in std_logic;
              w_en_ram_grille     : out std_logic;
              w_en_ram_ext        : out std_logic;
              sel_addr            : out std_logic;
              sel_addw            : out std_logic;
              sel_dataw           : out std_logic_vector (1 downto 0);
              val_btn_init        : out std_logic);
    end component;

    signal CLK                 : std_logic;
    signal RST                 : std_logic;
    signal CE                  : std_logic;
    signal cmp                 : std_logic;
    signal zero                : std_logic;
    signal btn_haut            : std_logic;
    signal btn_bas             : std_logic;
    signal btn_gauche          : std_logic;
    signal btn_droit           : std_logic;
    signal init_btn            : std_logic;
    signal cpt_ram_grille_en   : std_logic;
    signal cpt_ram_grille_init : std_logic;
    signal addr_max_ram_grille : std_logic;
    signal cpt_ram_ext_en      : std_logic;
    signal cpt_ram_ext_init    : std_logic;
    signal addr_max_ram_ext    : std_logic;
    signal w_en_ram_grille     : std_logic;
    signal w_en_ram_ext        : std_logic;
    signal sel_addr            : std_logic;
    signal sel_addw            : std_logic;
    signal sel_dataw           : std_logic_vector (1 downto 0);
    signal val_btn_init        : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : machine_etats
    port map (CLK                 => CLK,
              RST                 => RST,
              CE                  => CE,
              cmp                 => cmp,
              zero                => zero,
              btn_haut            => btn_haut,
              btn_bas             => btn_bas,
              btn_gauche          => btn_gauche,
              btn_droit           => btn_droit,
              init_btn            => init_btn,
              cpt_ram_grille_en   => cpt_ram_grille_en,
              cpt_ram_grille_init => cpt_ram_grille_init,
              addr_max_ram_grille => addr_max_ram_grille,
              cpt_ram_ext_en      => cpt_ram_ext_en,
              cpt_ram_ext_init    => cpt_ram_ext_init,
              addr_max_ram_ext    => addr_max_ram_ext,
              w_en_ram_grille     => w_en_ram_grille,
              w_en_ram_ext        => w_en_ram_ext,
              sel_addr            => sel_addr,
              sel_addw            => sel_addw,
              sel_dataw           => sel_dataw,
              val_btn_init        => val_btn_init);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK is really your main clock signal
    CLK <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        CE <= '1';
        cmp <= '0';
        zero <= '0';
        btn_haut <= '0';
        btn_bas <= '0';
        btn_gauche <= '0';
        btn_droit <= '0';
        addr_max_ram_grille <= '0';
        addr_max_ram_ext <= '0';

        -- Reset generation
        -- EDIT: Check that RST is really your reset signal
        
        RST <= '0';
        wait for 100 ns;
        RST <= '1';
        wait for 100 ns;

        
        -- EDIT Add stimuli here --INIT
        wait for 15 * TbPeriod;
        addr_max_ram_grille <= '1';        
                
        -- EDIT Add stimuli here --RECHERCHE 0
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0';
        wait for 9 * TbPeriod;
        zero <= '1';
  

        -- EDIT Add stimuli here --AJOUT NOMBRE
        wait for 1 * TbPeriod;
        zero <= '0';
        
        --EXPORT GRILLE
        wait for 15 * TbPeriod;
        addr_max_ram_ext <= '1';        

        
        -- EDIT Add stimuli here --WAITING
        wait for 1 * TbPeriod;
        addr_max_ram_ext <= '0'; 
        wait for 4 * TbPeriod;
        btn_haut <= '1';       

        -- EDIT Add stimuli here RECHERCHE 0
        wait for 1 * TbPeriod;
        btn_haut <= '0';
        wait for 4 * TbPeriod;
        zero <= '1';
        
        -- EDIT Add stimuli here DECALAGE
        wait for 1 * TbPeriod;
        zero <= '0';
        wait for 4 * TbPeriod;
        zero <= '1';
        
        -- EDIT Add stimuli here AJOUT 0
        wait for 1 * TbPeriod;
        zero <= '0';
        
        -- EDIT Add stimuli here RECHERCHE 0
        wait for (10 * TbPeriod) + 300 ns;
        addr_max_ram_grille <= '1';
        
        -- EDIT Add stimuli here Saving
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0';
        
        -- EDIT Add stimuli here CALCUL / SAVING
        wait for 10 * TbPeriod;
        cmp <= '1';
        
        -- EDIT Add stimuli here ADD
        wait for 1 * TbPeriod;
        cmp <= '0';
        
        -- EDIT Add stimuli here AJOUT ZERO
        wait for 1 * TbPeriod;
        cmp <= '0';
        
        -- EDIT Add stimuli here CALCUL / SAVING
        wait for 5 * TbPeriod;
        addr_max_ram_grille <= '1'; 
        
        -- EDIT Add stimuli here RECHERCHE 0
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0'; 
        wait for 10 * TbPeriod; -- DEc - ajout 0
        zero <= '1';
        wait for 1 * TbPeriod;
        zero <= '0';
        wait for 5* TbPeriod;
        addr_max_ram_grille <= '1'; 
        
        
      --------------------------------------------------
         
        -- EDIT Add stimuli here --RECHERCHE 0
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0';
        wait for 9 * TbPeriod;
        zero <= '1';
  

        -- EDIT Add stimuli here --AJOUT NOMBRE
        wait for 1 * TbPeriod;
        zero <= '0';
        
        --EXPORT GRILLE
        wait for 15 * TbPeriod;
        addr_max_ram_grille <= '1';        

        
        -- EDIT Add stimuli here --WAITING
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0'; 
        wait for 4 * TbPeriod;
        btn_haut <= '1';       

        -- EDIT Add stimuli here RECHERCHE 0
        wait for 1 * TbPeriod;
        btn_haut <= '0';
        wait for 4 * TbPeriod;
        zero <= '1';
        
        -- EDIT Add stimuli here DECALAGE
        wait for 1 * TbPeriod;
        zero <= '0';
        wait for 4 * TbPeriod;
        zero <= '1';
        
        -- EDIT Add stimuli here AJOUT 0
        wait for 1 * TbPeriod;
        zero <= '0';
        
        -- EDIT Add stimuli here RECHERCHE 0
        wait for 10 * TbPeriod;
        addr_max_ram_grille <= '1';
        
        -- EDIT Add stimuli here Saving
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0';
        
        -- EDIT Add stimuli here CALCUL / SAVING
        wait for 10 * TbPeriod;
        cmp <= '1';
        
        -- EDIT Add stimuli here AJOUT 0
        wait for 1 * TbPeriod;
        cmp <= '0';
        
        -- EDIT Add stimuli here CALCUL / SAVING
        wait for 5 * TbPeriod;
        addr_max_ram_grille <= '1'; 
        
        -- EDIT Add stimuli here RECHERCHE 0
        wait for 1 * TbPeriod;
        addr_max_ram_grille <= '0'; 
        wait for 14 * TbPeriod;
        addr_max_ram_grille <= '1'; 
         
        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_machine_etats of tb_machine_etats is
    for tb
    end for;
end cfg_tb_machine_etats;
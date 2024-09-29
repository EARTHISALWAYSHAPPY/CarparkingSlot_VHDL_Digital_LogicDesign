library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Parking_Counter_tb is
end Parking_Counter_tb;

architecture rtl of Parking_Counter_tb is

    
    component Parking_Counter
    Port ( clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        car_in : in STD_LOGIC;
        car_out : in STD_LOGIC;
        count : out INTEGER range 0 to 15;
        empty_count : out INTEGER range 0 to 15; --
        empty : out STD_LOGIC; --
        full : out STD_LOGIC);
end component;


signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal car_in : STD_LOGIC := '0';
signal car_out : STD_LOGIC := '0';
signal count : INTEGER range 0 to 15;
signal empty_count : INTEGER range 0 to 15; --
signal empty : STD_LOGIC; --
signal full : STD_LOGIC;

constant clk_period : time := 10 ms;
--signal   finished    : std_logic := '0';

begin
    
    uut: Parking_Counter
    Port map (
        clk => clk,
        reset => reset,
        car_in => car_in,
        car_out => car_out,                 
        count => count,
        empty_count => empty_count,
        empty => empty,
        full => full
    );

    
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    
    stim_proc: process
    begin
        
        reset <= '1';
        wait for clk_period / 2;
        reset <= '0';

        
        car_in <= '1';
        wait for clk_period / 2;
        car_in <= '0';
        wait for clk_period / 2;

        car_in <= '1';
        wait for clk_period / 2;
        car_in <= '0';
        wait for clk_period / 2;

        car_in <= '1';
        wait for clk_period / 2;
        car_in <= '0';
        wait for clk_period / 2;

        
        car_out <= '1';
        wait for clk_period / 2;
        car_out <= '0';
        wait for clk_period / 2;

        
        for i in 1 to 13 loop
            car_in <= '1';
            wait for clk_period / 2;
            car_in <= '0';
            wait for clk_period / 2;
        end loop;

        
        wait for clk_period * 4;

        
        for i in 1 to 15 loop
            car_out <= '1';
            wait for clk_period / 2;
            car_out <= '0';
            wait for clk_period / 2;
        end loop;

        
        reset <= '1';
        wait for clk_period / 2;
        reset <= '0';
        wait for clk_period * 4;

        wait;
        
    end process;

end architecture rtl;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--Set Testbench for Parking_Counter.
entity Parking_Counter_tb is
end Parking_Counter_tb;

architecture rtl of Parking_Counter_tb is

    --Set component of Parking_Counter for testbench.
    component Parking_Counter
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        car_in : in STD_LOGIC;
        car_out : in STD_LOGIC;
        count : out INTEGER range 0 to 18;
        empty_count : out INTEGER range 0 to 18;
        empty : out STD_LOGIC;
        full : out STD_LOGIC
    );
end component;

--Set signals use on testbench.
signal clk : STD_LOGIC := '0';
signal reset : STD_LOGIC := '0';
signal car_in : STD_LOGIC := '0';
signal car_out : STD_LOGIC := '0';
signal count : INTEGER range 0 to 18;
signal empty_count : INTEGER range 0 to 18;
signal empty : STD_LOGIC;
signal full : STD_LOGIC;

-- Set the clock(clk) signal period.
constant clk_period : time := 10 ms;

begin
    
    --Module Parking_Counter.
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

    --Generate a clock signal.
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    --Stimulus Process
    stim_proc: process
    begin
        --Reset Test
        reset <= '1';  --reset
        wait for clk_period;  --Waiting
        reset <= '0';  --Unreset
        
        --state test of car in.
        for i in 1 to 18 loop
            car_in <= '1';  --carin
            wait for clk_period; --Waiting
            car_in <= '0';
            wait for clk_period; --Waiting
        end loop;

        --Test in the case where another car enters after 
        --the parking lot is full (should not increase count)
        car_in <= '1';  --carin
        wait for clk_period;
        car_in <= '0';
        wait for clk_period;

        --If you enter and exit at the same time,
        --the counter will be the same.
        car_in <= '1';  --carin
        car_out <= '1';  --carout
        wait for clk_period;
        car_in <= '0';
        car_out <= '0';
        wait for clk_period;

        --state test of car out.
        for i in 1 to 18 loop
            car_out <= '1';  --carout
            wait for clk_period; --Waiting
            car_out <= '0';
            wait for clk_period; --Waiting
        end loop;

        reset <= '1';  --reset
        wait for clk_period;
        reset <= '0';  --unreset

        wait;
    end process;

end architecture rtl;

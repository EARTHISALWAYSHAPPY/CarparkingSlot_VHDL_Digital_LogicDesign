library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--Set the module port of Parking_slot
entity Parking_Counter is
    Port ( clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        car_in : in STD_LOGIC;
        car_out : in STD_LOGIC;
        count : out INTEGER range 0 to 18;
        empty_count : out INTEGER range 0 to 18;
        empty : out STD_LOGIC;
        full : out STD_LOGIC);
end Parking_Counter;

architecture rtl of Parking_Counter is
    --carparking count from 0 to 18, starting at 0.
    signal counter : INTEGER range 0 to 18 := 0;
begin

    process(clk, reset)
    begin
        --reset --> counter = 0.
        if reset = '1' then
            counter <= 0;
        --Tasks on the rising edge of clk.
        elsif rising_edge(clk) then
            
            --If you enter and exit at the same time,
            --the counter will be the same to prevent bugs.
            if car_in = '1' and car_out = '1' then
                counter <= counter;
                
            -- If you enter and the parking lot is not full (counter less than 18).
            elsif car_in = '1' and counter < 18 then
                -- Increment the counter by 1.
                counter <= counter + 1;
                
            -- If exit and there is a car in the parking lot.
            elsif car_out = '1' and counter > 0 then
                --Decrease the counter cost by 1.
                counter <= counter - 1;
            end if;
            
        end if;
        
    end process;

    count <= counter;
    
    --empty_count = 18 (Full) - counter.
    empty_count <= 18 - counter;
    
    --'1' when the parking lot is full (counter = 18).
    full <= '1' when counter = 18 else '0';

    --'1' when the parking lot is empty (counter = 0)
    empty <= '1' when counter >= 0 and counter < 18 else '0';
    
end architecture rtl;

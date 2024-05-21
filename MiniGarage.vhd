library ieee;
use ieee.std_logic_1164.all;
use work.Sensor_package.all;
use work.Gate_package.all;

entity MiniGarage is
port(sensor_in, sensor_out: in std_logic;
	  button_in, button_out: in std_logic;
	  clk: in std_logic;
	  pwm_in, pwm_out: out std_logic;
	  seg1, seg2: out  std_logic_vector (0 to 6));
end MiniGarage;

architecture behaviour of MiniGarage is
signal enable, flagin, flagout: std_logic;
begin
motor_in: GATE port map (clk, button_in, sensor_in, pwm_in, flagin);
motor_out: GATE port map (clk, button_out, sensor_out, pwm_out,flagout);
enable<=(flagin or flagout);
counter: Sensor port map (sensor_in, sensor_out, clk, enable , seg1, seg2);
end behaviour;
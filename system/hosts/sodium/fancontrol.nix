{
  pkgs,
  config,
  ...
}: {
  boot.kernelModules = ["lm83" "nct6775"];

  hardware.fancontrol = {
    enable = true;
    config = ''
      # Configuration file generated by pwmconfig, changes will be lost
      INTERVAL=10
      DEVPATH=hwmon1=devices/platform/nct6775.656 hwmon2=devices/pci0000:00/0000:00:18.3
      DEVNAME=hwmon1=nct6798 hwmon2=k10temp
      FCTEMPS=hwmon1/pwm1=/run/nvidia-temp hwmon1/pwm2=hwmon2/temp1_input hwmon1/pwm3=hwmon2/temp1_input hwmon1/pwm4=hwmon2/temp1_input hwmon1/pwm5=/run/nvidia-temp
      FCFANS=hwmon1/pwm1=hwmon1/fan1_input hwmon1/pwm2=hwmon1/fan2_input hwmon1/pwm3=hwmon1/fan3_input hwmon1/pwm4=hwmon1/fan4_input hwmon1/pwm5=hwmon1/fan5_input
      MINTEMP=hwmon1/pwm1=45 hwmon1/pwm2=45 hwmon1/pwm3=45 hwmon1/pwm4=45 hwmon1/pwm5=45
      MAXTEMP=hwmon1/pwm1=70 hwmon1/pwm2=80 hwmon1/pwm3=80 hwmon1/pwm4=80 hwmon1/pwm5=70
      MINSTART=hwmon1/pwm1=20 hwmon1/pwm2=20 hwmon1/pwm3=20 hwmon1/pwm4=20 hwmon1/pwm5=20
      MINSTOP=hwmon1/pwm1=0 hwmon1/pwm2=0 hwmon1/pwm3=0 hwmon1/pwm4=0 hwmon1/pwm5=0
      MAXPWM=hwmon1/pwm1=210 hwmon1/pwm2=210 hwmon1/pwm3=210 hwmon1/pwm4=210 hwmon1/pwm5=210
    '';
  };

  # https://www.reddit.com/r/linuxquestions/comments/s8odfm/comment/htkp2td/
  # TODO maybe create a timer for this instead of a loop
  systemd.services.nvidia-temp = {
    enable = true;
    description = "Nvidia GPU temperature reader";
    wantedBy = ["fancontrol.service"];
    serviceConfig = {
      Restart = "on-failure";
    };
    path = with pkgs; [
      bash
      config.hardware.nvidia.package
    ];
    script = ''
      bash -c 'while :; do
        t="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)";
        echo "$((t * 1000))" > /run/nvidia-temp;
        sleep 2;
      done'
    '';
  };
}

# Drone Autonome — Navigation VIO sans GPS (ROS 2 Humble)

Environnement conteneurisé **ROS 2 Humble** multi-architecture (`amd64` pour développement WSL2 / PC et `arm64` pour déploiement embarqué sur Raspberry Pi 5) dédié au vol autonome d'un drone quadricoptère sous **ArduPilot** en environnement dépourvu de GPS.

## Architecture matérielle
* **Calculateur embarqué :** Raspberry Pi 5 (Ubuntu Server 22.04 `arm64`)
* **Contrôleur de vol :** Pixhawk 6C (ArduPilot Copter, liaison série MAVLink via `TELEM2`)
* **Capteurs :** Caméra Global Shutter IMX296, IMU SPI ICM-42688-P, capteur optique/télémètre MTF-02P

## Structure du dépôt
```text
drone_autonome/
├── Dockerfile              # Image ROS 2 Humble + OpenCV + Eigen + pymavlink
├── docker-compose.yml      # Lancement et montage du workspace
└── src/
    ├── imu_driver/         # Acquisition et publication des données IMU
    └── mavlink_bridge/     # Passerelle ROS 2 <-> ArduPilot (MAVLink)


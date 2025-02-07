# 15-cloudproj-03

Используя конфигурацию из репозитория `15-cloudproj-02`, отредактируем настройки бакета и добавим конфигурацию для защиты нашего Object Storage
Для этого создадим сервисный аккаунт для управления Obj.Str., выдадим привелегии для управления хранилищем, создадим ключи для хранилища, и создадим симметричный ключ.

Наше хранилище:
![image](https://github.com/user-attachments/assets/a240e6ad-297b-4535-badc-5485775e23c4)

Параметры нашего хранилища:
![image](https://github.com/user-attachments/assets/123ca822-32af-4e63-a036-fb80d2f955f0)

Настройки бесопастности:
![image](https://github.com/user-attachments/assets/9a380d37-fc59-4a82-ba39-96d8441d6786)

Наш созданный ключ:
![image](https://github.com/user-attachments/assets/0516274e-306e-4fa1-be52-6543607f2e13)

Посмотри что указано о нашем загруженном обьекте в хранилище:
![Screenshot 2025-02-07 201601](https://github.com/user-attachments/assets/3faf8fdc-3a73-4e59-a7e0-f7b4396c0176)

Как видим обект использует ключ шифрования

Создадим сайд через WEB-Консоль
Так как через терраформ бакет не публичный получаем ошибку:

![image](https://github.com/user-attachments/assets/2a6cf2d4-6a5c-4e04-b932-e79644d264f6)


![image](https://github.com/user-attachments/assets/00c31352-e6a6-41e4-b146-830b1f246183)


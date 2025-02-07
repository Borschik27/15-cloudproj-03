# 15-cloudproj-03

Используя конфигурацию из репозитория `15-cloudproj-02`, отредактируем настройки бакета и добавим конфигурацию для защиты нашего Object Storage
## Задача 1
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

Попробуем открыть web-доступ и посмотри что получится
![image](https://github.com/user-attachments/assets/b87f171b-4beb-4de8-afe6-9fecc5c98725)
Так как наш бакет шифрованный kms мы видим ошибку.

Как еще можно убедиться что шифруется наше хранилище и kms работает закоментируем строку которая создает наш kms и пересоздадим бакет
```
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.kms_key.id
        sse_algorithm = "aws:kms"
      }
    }
  }


```
Теперь мы видим в настройках файл что нет использование kms ключа и наш бакет публичный
![image](https://github.com/user-attachments/assets/004cc714-431a-4d45-8567-01292add8969)

Откроем web доступ и помотри доступен ли наш сайт и возможно ли скачать файл
Сайт взят из шаблона cloud-init  который создается в `15-cloudproj-02` и добавляется в бакет как стартавая страница

![image](https://github.com/user-attachments/assets/ba488b9e-9ad3-4d9b-809a-3bfd37002c73)

Перейдем на сайт и видим что он открывается и мы так же можем скачать файл:

![image](https://github.com/user-attachments/assets/56891e42-8903-4071-ad9f-4e021dc9e760)

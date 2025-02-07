### Create KMS key
resource "yandex_kms_symmetric_key" "kms_key" {
  name              = "bucket_key"
  folder_id         = var.folder_id
  description       = "Key for bucket ${var.bucket_name}"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}

### Create Service Account for bucket
resource "yandex_iam_service_account" "sa_ba" {
  folder_id   = var.folder_id
  name        = "bucket-admin"
  description = "service account to bucket administration"
}

### Grand permissions for bucket_admin
resource "yandex_resourcemanager_folder_iam_member" "sa_ba-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa_ba.id}"
}

### Create Access/Secret Key for bucket admin
resource "yandex_iam_service_account_static_access_key" "sa_ba-static-key" {
  service_account_id = yandex_iam_service_account.sa_ba.id
  description        = "Access key for bucket"
}

### Create bucket
resource "yandex_storage_bucket" "bucket" {
  bucket     = var.bucket_name
  max_size   = 1073741824
  access_key = yandex_iam_service_account_static_access_key.sa_ba-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_ba-static-key.secret_key

  grant {
    id          = yandex_iam_service_account.sa_ba.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }

  # server_side_encryption_configuration {
  #   rule {
  #     apply_server_side_encryption_by_default {
  #       kms_master_key_id = yandex_kms_symmetric_key.kms_key.id
  #       sse_algorithm = "aws:kms"
  #     }
  #   }
  # }

  default_storage_class = "STANDARD"
  folder_id = var.folder_id

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = true
  }
}

### Upload file on bucket
resource "yandex_storage_object" "image" {
  access_key = yandex_iam_service_account_static_access_key.sa_ba-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_ba-static-key.secret_key
  bucket     = yandex_storage_bucket.bucket.bucket
  key        = "images/main.png"
  source     = var.image_path
}

resource "yandex_storage_object" "index" {
  access_key = yandex_iam_service_account_static_access_key.sa_ba-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_ba-static-key.secret_key
  bucket     = yandex_storage_bucket.bucket.bucket
  key        = "index.html"
  source     = "./files/index.html"
}


1. Membuat aplikasi sederhana yaitu konversi Markdown ke HTML yang dibangun dengan Laravel framework.
2. Membuat Dockerfile untuk aplikasi laravel. Dockerfile menggunakan image php8.1-apache yang berjalan di port 80.
3. Membuat yaml file untuk deployment kubernetes yang berisi kind Deployment, Service, HorizontalPodAutoscaler(HPA).
4. Mendeploy aplikasi ke kuberneter.

   ![image](image/Screenshot_1.jpg)
   
5. Setelah itu cek pod, service dan hpa dengan perintah kubectl get all. pod berjalan 3 pod sesuai dengan replica HPA. Autoscaler akan berjalan jika resource cpu / memory mencapai 70%.

   ![image](image/Screenshot_3.jpg)

6. Konfigure nginx sebagai proxy.
   ![image](image/Screenshot_4.jpg)
   
7. Aplikasi berhasil di akses.
   ![image](image/Screenshot_2.jpg)

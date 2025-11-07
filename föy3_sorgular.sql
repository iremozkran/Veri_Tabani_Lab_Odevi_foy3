--3.Yazılım veya Donanım birimlerinde çalışanların ad, soyad ve maaş bilgilerini listeleyen SQL sorgusu
  
SELECT calisanlar.ad, calisanlar.soyad, calisanlar.maas, birimler.birim_ad
FROM calisanlar 
JOIN birimler  ON calisanlar.calisan_birim_id = birimler.birim_id
WHERE birimler.birim_ad IN ('Yazılım', 'Donanım');

--4.Maaşı en yüksek olan çalışanların ad, soyad ve maaş bilgilerini listeleyen SQL sorgusu

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas = (SELECT MAX(maas) FROM calisanlar);

--5.Seçenek

SELECT birimler.birim_ad, COUNT(calisanlar.calisan_id) AS calisan_Sayisi
FROM calisanlar 
JOIN birimler  ON calisanlar.calisan_birim_id = birimler.birim_id
GROUP BY birimler.birim_ad;

--6.Birden fazla çalışana ait olan unvanların isimlerini ve o unvan altında çalışanların sayısını listeleyen sorgu

SELECT unvan.unvan_calisan AS unvan, COUNT(unvan.unvan_calisan_id) AS calisan_Sayisi
FROM unvan 
GROUP BY unvan.unvan_calisan
HAVING COUNT(unvan.unvan_calisan_id) > 1;

--7.Maaşları 50000 ve 100000 arasında değişen çalışanların ad, soyad ve maaş bilgilerini listeleyen sorgu

SELECT ad, soyad, maas
FROM calisanlar
WHERE maas BETWEEN 50000 AND 100000;

--8.İkramiye hakkına sahip çalışanlara ait ad, soyad, birim, unvan ve ikramiye ücreti bilgilerini listeleyen sorgu

SELECT 
    calisanlar.ad, 
    calisanlar.soyad, 
    birimler.birim_ad, 
    unvan.unvan_calisan AS Unvan, 
    ikramiye.ikramiye_ucret AS Ikramiye
FROM calisanlar
JOIN birimler ON calisanlar.calisan_birim_id = birimler.birim_id
JOIN unvan ON calisanlar.calisan_id = unvan.unvan_calisan_id
JOIN ikramiye ON calisanlar.calisan_id = ikramiye.ikramiye_calisan_id

--9.Ünvanı Yönetici ve Müdür olan çalışanların ad, soyad ve ünvanlarını listeleyen sorgu

SELECT 
    calisanlar.ad, 
    calisanlar.soyad, 
    unvan.unvan_calisan AS Unvan
FROM calisanlar 
JOIN unvan  ON calisanlar.calisan_id = unvan.unvan_calisan_id
WHERE unvan.unvan_calisan IN ('Yönetici', 'Müdür');

--10.Her bir birimde en yüksek maaş alan çalışanların ad, soyad ve maaş bilgilerini listeleyen sorgu

SELECT 
    calisanlar.ad, 
    calisanlar.soyad, 
    calisanlar.maas, 
    birimler.birim_ad
FROM calisanlar
JOIN birimler ON calisanlar.calisan_birim_id = birimler.birim_id
WHERE calisanlar.maas = (
    SELECT MAX(c2.maas)
    FROM calisanlar c2
    WHERE c2.calisan_birim_id = calisanlar.calisan_birim_id);

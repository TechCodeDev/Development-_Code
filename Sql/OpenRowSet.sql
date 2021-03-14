INSERT INTO Production.ProductPhoto (ThumbNailPhoto,ThumbnailPhotoFileName,LargePhoto,LargePhotoFileName)
SELECT *  , 'P1.jpg',* , 'P1.jpg' FROM OPENROWSET(BULK 'C:\Users\Qipl143\Pictures\Flowers\P1.jpg', SINGLE_BLOB) AS Document;


SELECT * FROM OPENROWSET(BULK 'C:\Users\Qipl143\Pictures\Flowers\P1.jpg', SINGLE_BLOB) AS Document
 

INSERT INTO Production.ProductPhoto (ThumbNailPhoto,ThumbnailPhotoFileName,LargePhoto,LargePhotoFileName)
SELECT *  , 'test.docx',* , 'test.docx' FROM OPENROWSET(BULK 'C:\Users\Qipl143\Downloads\coding_test.docx', SINGLE_BLOB) AS Document;
 

USE master;
GO

EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

EXEC sp_configure 'EKM provider enabled', 1;
GO
RECONFIGURE;

CREATE CRYPTOGRAPHIC PROVIDER EKMDemo
FROM FILE = 'C:\Program Files\SQL Server Connector for Microsoft Azure Key Vault\Microsoft.AzureKeyVaultService.EKM.dll';
GO

USE master;
CREATE CREDENTIAL sysadmin_ekm_cred
    WITH IDENTITY = 'ContosoEKMKeyVault',                           
    SECRET = '83d8624c17544ce9a7ac3bcc4e710e7c28865c03bdbd43df93d2b2062b774f1c'
FOR CRYPTOGRAPHIC PROVIDER EKMDemo;

ALTER LOGIN [WIN-L15G2LLATPO\Administrator]
ADD CREDENTIAL sysadmin_ekm_cred;

CREATE ASYMMETRIC KEY EKMDemoKey
FROM PROVIDER [EKMDemo]
WITH PROVIDER_KEY_NAME = 'EKMDemo',
CREATION_DISPOSITION = OPEN_EXISTING;
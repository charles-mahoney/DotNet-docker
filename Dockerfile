FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

USER 1001

COPY /deployment/app.dll .
EXPOSE 80
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y iputils-ping

RUN dotnet CertificateInstaller.dll installca certs/ca.pem
RUN dotnet CertificateInstaller.dll installca certs/public_key.pem

ENTRYPOINT ["dotnet", "app.dll"]

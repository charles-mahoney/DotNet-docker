FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

WORKDIR /App

COPY /deployment .

#EXPOSE 80
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y iputils-ping

#RUN dotnet CertificateInstaller.dll installca certs/ca.pem
#RUN dotnet CertificateInstaller.dll installca certs/public_key.pem

RUN chmod 777 *
USER 1001
RUN chown -R 1001:0 .

#ENTRYPOINT ["dotnet", "app.dll"]
ENTRYPOINT ["sleep", "100000000"]

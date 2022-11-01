FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

WORKDIR /App

COPY /deployment .

#EXPOSE 80
EXPOSE 5296
EXPOSE 41431
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y iputils-ping

#RUN dotnet CertificateInstaller.dll installca certs/ca.pem
#RUN dotnet CertificateInstaller.dll installca certs/public_key.pem

## run as www-data(33), readonly
RUN chown -R 1001:0 /
RUN chmod -R 777 /
RUN chmod -R 777 *.dll # if the dll's are not writeable, it won't start
USER 1001

#ENTRYPOINT ["dotnet", "myapp.dll"]
ENTRYPOINT ["sleep", "100000000"]

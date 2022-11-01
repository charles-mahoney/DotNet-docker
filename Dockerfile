FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /App
COPY /deployment/app.dll .
EXPOSE 80
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y iputils-ping

USER 1001

ENTRYPOINT ["dotnet", "/App/app.dll"]

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
RUN apt-get update && apt-get install -y telnet
RUN apt-get update && apt-get install -y iputils-ping

ENTRYPOINT ["dotnet", "app.dll"]

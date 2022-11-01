FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

USER root
WORKDIR /App

COPY /deployment .

#EXPOSE 80
EXPOSE 5296
EXPOSE 5000
EXPOSE 41431
RUN apt-get update && apt-get install -y telnet
#RUN apt-get update && apt-get install -y curl
RUN apt-get update && apt-get install -y iputils-ping

#RUN dotnet CertificateInstaller.dll installca certs/public_key.pem

ENV \
    # Unset ASPNETCORE_URLS from aspnet base image
    ASPNETCORE_URLS= \
    # Do not generate certificate
    DOTNET_GENERATE_ASPNET_CERTIFICATE=false \
    # Do not show first run text
    DOTNET_NOLOGO=true \
    # SDK version
    DOTNET_SDK_VERSION=6.0.402

#RUN curl -fSL --output dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz \
#    && dotnet_sha512='972c2d9fff6a09ef8f2e6bbaa36ae5869f4f7f509ae5d28c4611532eb34be10c629af98cdf211d86dc4bc6edebb04a2672a97f78c3e0f2ff267017f8c9c59d4e' \
#    && echo "$dotnet_sha512  dotnet.tar.gz" | sha512sum -c - \
#    && mkdir -p /usr/share/dotnet \
#    && tar -oxzf dotnet.tar.gz -C /usr/share/dotnet ./packs ./sdk ./sdk-manifests ./templates ./LICENSE.txt ./ThirdPartyNotices.txt \
#    && rm dotnet.tar.gz \
#    # Trigger first run experience by running arbitrary cmd
#    && dotnet help


    #RUN dotnet CertificateInstaller.dll installca certs/ca2.pem

## run as www-data(33), readonly
RUN chown -R 1001:0 ./
RUN chmod -R 700 ./
RUN chmod -R 770 *.dll # if the dll's are not writeable, it won't start
USER 1001



ENTRYPOINT ["dotnet", "myapp.dll"]
#ENTRYPOINT ["sleep", "100000000"]

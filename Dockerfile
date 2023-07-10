FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
        && apt update \
        && apt install -y gss-ntlmssp \
        && apt install -y apt-utils \
        && apt install -y libgdiplus \
        && apt install -y libc6-dev \
        && apt install -y nodejs
RUN npm install -g npm
RUN npm install -g wscat
RUN npm install -g @angular/cli@12.1

RUN sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /etc/ssl/openssl.cnf 
RUN sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1/g' /etc/ssl/openssl.cnf 
RUN sed -i 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/g' /usr/lib/ssl/openssl.cnf 
RUN sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1/g' /usr/lib/ssl/openssl.cnf 

ENV TZ=America/Recife
ENV ASPNETCORE_ENVIRONMENT=Production

EXPOSE 5002

WORKDIR /app

ENTRYPOINT ["dotnet","B2B.dll"]

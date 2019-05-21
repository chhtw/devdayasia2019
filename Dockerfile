FROM mcr.microsoft.com/dotnet/core/aspnet:2.2 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /src
COPY ["demo.csproj", "."]
RUN dotnet restore "demo.csproj"
COPY . .
RUN dotnet build "demo.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "demo.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "demo.dll"]
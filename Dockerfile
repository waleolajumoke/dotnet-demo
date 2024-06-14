FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out
EXPOSE 8080
# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine 
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "profile.dll"]

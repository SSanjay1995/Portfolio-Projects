select *
from PortfolioProject.dbo.NashvilleHousing

select SaleDateConverted, CONVERT(date, SaleDate)
from PortfolioProject.dbo.NashvilleHousing

update NashvilleHousing
set SaleDate=convert(date,SaleDate) 

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

update NashvilleHousing
set SaleDateConverted=convert(date,SaleDate) 

--Property Address

select *
from PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = isnull (a.PropertyAddress,b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
join PortfolioProject.dbo.NashvilleHousing b
     on a.ParcelID = b.ParcelID
	 and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

select PropertyAddress
from PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX (',',PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX (',',PropertyAddress)+1, LEN(PropertyAddress)) as Address

From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress= SUBSTRING(PropertyAddress, 1, CHARINDEX (',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

update NashvilleHousing
set PropertySplitCity=SUBSTRING(PropertyAddress, CHARINDEX (',',PropertyAddress)+1, LEN(PropertyAddress))

SELECT *
From PortfolioProject.dbo.NashvilleHousing

Select OwnerAddress
From PortfolioProject.dbo.NashvilleHousing

select 
PARSENAME(REPLACE (OwnerAddress,',','.'),3)
, PARSENAME(REPLACE (OwnerAddress,',','.'),2)
, PARSENAME(REPLACE (OwnerAddress,',','.'),1)

From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress= PARSENAME(REPLACE (OwnerAddress,',','.'),3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

update NashvilleHousing
set OwnerSplitCity=PARSENAME(REPLACE (OwnerAddress,',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

update NashvilleHousing
set OwnerSplitState= PARSENAME(REPLACE (OwnerAddress,',','.'),1)

SELECT *
From PortfolioProject.dbo.NashvilleHousing

Select Distinct (SoldasVacant), COUNT(SoldasVacant)
From PortfolioProject.dbo.NashvilleHousing
group by SoldasVacant
order by 2


Select SoldasVacant
, Case When SoldasVacant = 'Y' THEN 'Yes' 
       WHEN SoldasVacant= 'N' THEN 'No'
	   ELSE SoldasVacant
	   END
From PortfolioProject.dbo.NashvilleHousing


Update NashvilleHousing
set SoldAsVacant = Case When SoldasVacant = 'Y' THEN 'Yes' 
       WHEN SoldasVacant= 'N' THEN 'No'
	   ELSE SoldasVacant
	   END


WITH RowNumCTE AS(
SELECT *,
        ROW_NUMBER() OVER (
		PARTITION BY ParcelID,
				     PropertyAddress,
					 SalePrice,
					 SaleDate,
					 LegalReference
					 ORDER BY 
					    UniqueID
						) row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
SELECT *
FROM RowNumCTE
where row_num >1
order by PropertyAddress

SELECT *
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN SaleDate












/**
 * Mandelbulber v2, a 3D fractal generator  _%}}i*<.        ____                _______
 * Copyright (C) 2017 Mandelbulber Team   _>]|=||i=i<,     / __ \___  ___ ___  / ___/ /
 *                                        \><||i|=>>%)    / /_/ / _ \/ -_) _ \/ /__/ /__
 * This file is part of Mandelbulber.     )<=i=]=|=i<>    \____/ .__/\__/_//_/\___/____/
 * The project is licensed under GPLv3,   -<>>=|><|||`        /_/
 * see also COPYING file in this folder.    ~+{i%+++
 *
 * spherical fold Cuboid
 * This has a box shape MinR2 condition
 * This formula contains aux.color

 * This file has been autogenerated by tools/populateUiInformation.php
 * from the function "TransfSphericalFoldCuboidIteration" in the file fractal_formulas.cpp
 * D O    N O T    E D I T    T H I S    F I L E !
 */

REAL4 TransfSphericalFoldCuboidIteration(
	REAL4 z, __constant sFractalCl *fractal, sExtendedAuxCl *aux)
{
	REAL4 temp3;
	REAL4 R2;
	REAL minR2 = fractal->transformCommon.minR2p25;
	REAL4 limitMinR2 = fractal->transformCommon.scaleP222;
	REAL m = fractal->transformCommon.scale;

	REAL rr = dot(z, z);
	z += fractal->transformCommon.offset000;

	if (aux->i >= fractal->transformCommon.startIterationsA
			&& aux->i < fractal->transformCommon.stopIterationsA)
	{
		if (fractal->transformCommon.functionEnabledAxFalse)
			temp3 = z * z;
		else
			temp3 = fabs(z);

		if (temp3.x < limitMinR2.x && temp3.y < limitMinR2.y && temp3.z < limitMinR2.z)
		{ // if inside cuboid
			R2.x = native_divide(limitMinR2.x, temp3.x);
			R2.y = native_divide(limitMinR2.y, temp3.y);
			R2.z = native_divide(limitMinR2.z, temp3.z);
			REAL First = min(R2.x, min(R2.y, R2.z));
			minR2 = rr * First;

			if (fractal->transformCommon.functionEnabled && minR2 > fractal->transformCommon.maxR2d1)
			{ // stop overlapping potential
				minR2 = fractal->transformCommon.maxR2d1;
			}

			m *= native_divide(fractal->transformCommon.maxR2d1, minR2);
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp1;
			}
		}
		else if (rr < fractal->transformCommon.maxR2d1)
		{
			m *= native_divide(fractal->transformCommon.maxR2d1, rr);
			if (fractal->foldColor.auxColorEnabledFalse)
			{
				aux->color += fractal->mandelbox.color.factorSp2;
			}
		}
	}
	else if (rr < minR2)
	{
		m *= native_divide(fractal->transformCommon.maxR2d1, minR2);
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			aux->color += fractal->mandelbox.color.factorSp1;
		}
	}
	else if (rr < fractal->transformCommon.maxR2d1)
	{
		m *= native_divide(fractal->transformCommon.maxR2d1, rr);
		if (fractal->foldColor.auxColorEnabledFalse)
		{
			aux->color += fractal->mandelbox.color.factorSp2;
		}
	}
	z -= fractal->transformCommon.offset000;

	// scale
	z *= m;
	aux->DE = mad(aux->DE, fabs(m), 1.0f);
	return z;
}
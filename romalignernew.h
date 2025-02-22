#ifndef ROMALIGNERNEW_H
#define ROMALIGNERNEW_H

#include "romaligner.h"

//This aligner is slow as dirt on large projects.  Must be replaced.
class RomAlignerNew : public RomAligner {
    RomBitItem* markBitTable(MaskRomTool* mrt);

private:
    QList<RomBitItem *> rowstarts; //All left-most bits of a row.
    QList<RomBitItem *> leftsorted; //All bits sorted from left.
    QList<RomBitItem *> topsorted; //All bits sorted from left.

    RomBitItem* linkresults();
    void markRowStarts();
    void markRemainingBits();

    uint32_t threshold=5;  //Overwritten from MRT.
};

#endif // ROMALIGNERNEW_H

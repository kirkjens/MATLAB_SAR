function [ boolout ] = iscsm( filename )
%ISCSM Is Cosmo Skymed HFD5 file format
%
% Written by: Wade Schwartzkopf, NGA/IDT
%
% //////////////////////////////////////////
% /// CLASSIFICATION: UNCLASSIFIED       ///
% //////////////////////////////////////////

fid = fopen(filename,'r','b');
boolout = isequal(fread( fid, 8, 'uint8' )',[137 72 68 70 13 10 26 10]); % HDF5 signature
fclose(fid);
% Now that we know it is HDF5, is it CSM HDF5?
if boolout
    try % Error if root attribute 'Mission ID' does not exist
        boolout=strcmpi(h5readatt(filename,'/','Mission ID'), 'CSK');
    catch % h5readatt replaced hdf5read at some point in MATLAB history
        try
            boolout=strcmpi(hdf5read(filename,'/','Mission ID'), 'CSK');
        catch % Is there a more direct way to check for attribute existence first?
            boolout=false;
        end
    end
end

end

% //////////////////////////////////////////
% /// CLASSIFICATION: UNCLASSIFIED       ///
% //////////////////////////////////////////
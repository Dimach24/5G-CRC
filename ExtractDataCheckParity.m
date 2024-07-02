function [data,is_data_valid]=ExtractDataCheckParity(bitstream,crc_type)
    arguments
        bitstream
        crc_type string
    end
    switch(crc_type)
        case "crc6"
            N=6;
        case "crc11"
            N=11;
        case "crc16"
            N=16;
        case {"crc24a","crc24b","crc24c"}
            N=24;
        otherwise
            throw(MException('crcTypeErr',...
                "Invalid crc type. Must be one of {crc6, crc11," + ...
                "crc16, crc24a, crc24b, crc24c}."))
    end
    data=bitstream(1:end-N);
    [~,crc]=AttachParityBits(bitstream,crc_type,false);
    is_data_valid=~any(crc);
end

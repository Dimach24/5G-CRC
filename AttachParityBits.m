function [data_with_crc,crc]=AttachParityBits(bitstream,crc_type,attach_zeros)
    arguments
        bitstream
        crc_type string
        attach_zeros=true
    end
    switch(crc_type)
        case "crc6"
            Dpos=[5 0];
            N=6;
        case "crc11"
            Dpos=[10 9 5 0];
            N=11;
        case "crc16"
            Dpos=[12 5 0];
            N=16;
        case "crc24a"
            Dpos=[23 18 17 14 11 10 7 6 5 4 3 1 0]+1;
            N=24;
        case "crc24b"
            Dpos=[23 6 5 1 0]+1;
            N=24;
        case "crc24c"
            Dpos=[23 21 20 17 15 13 12 8 4 2 1 0]+1;
            N=24;
        otherwise
            throw(MException('crcTypeErr',...
                "Invalid crc type. Must be one of {crc6, crc11," + ...
                "crc16, crc24a, crc24b, crc24c}."))
    end
    Dpos=25-Dpos;
    L=length(bitstream);
    if attach_zeros
        bitstream=[bitstream, zeros(1,N)];
    else
        L=L-N;
    end
    crc=bitstream(1:N);
    for n=1:L
        pulled_bit=crc(1);
        % shifting the word
        crc=circshift(crc,-1);
        crc(N)=bitstream(n+N);
        if pulled_bit
            crc(Dpos)=~crc(Dpos);
        end
    end
    data_with_crc=[bitstream(1:L), crc];
end
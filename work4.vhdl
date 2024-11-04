-- Chapter 4
package time_vector_sampling is
    type time_samples is array (positive range <>) of time_vector;
    subtype four_samples is time_samples(1 to 4);
    subtype ten_times is four_samples(open)(1 to 10);
end package;